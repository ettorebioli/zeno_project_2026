#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import matplotlib.pyplot as plt
import threading

# TODO: sostituisci con i tuoi tipi reali
from marta_msgs.msg import NavStatus          # <-- cambia se il msg ha un altro nome / package
from joystick_command.msg   import Rel_error_joystick


class DepthHeavePlotter(object):
    def __init__(self):
        # Parametri
        self.navstatus_topic   = rospy.get_param("~navstatus_topic",   "/nav_status")
        self.trigger_topic     = rospy.get_param("~trigger_topic",     "/relative_error")  # cambia se serve
        self.plot_title        = rospy.get_param("~plot_title",        "Depth & Heave velocity")
        self.rate_hz           = rospy.get_param("~plot_rate",         20.0)

        # Stato interno
        self.started = False       # diventa True al primo msg su /relative_error
        self.start_time = None

        self.lock = threading.Lock()
        self.times  = []
        self.depths = []
        self.heaves = []

        # Figure matplotlib
        plt.ion()
        self.fig, (self.ax_depth, self.ax_heave) = plt.subplots(2, 1, sharex=True)
        self.fig.suptitle(self.plot_title)

        self.line_depth, = self.ax_depth.plot([], [], label="Depth [m]")
        self.line_heave, = self.ax_heave.plot([], [], label="Heave velocity [m/s]")

        self.ax_depth.set_ylabel("Depth [m]")
        self.ax_depth.grid(True)
        self.ax_depth.legend(loc="upper right")

        self.ax_heave.set_xlabel("Time [s]")
        self.ax_heave.set_ylabel("v_heave [m/s]")
        self.ax_heave.grid(True)
        self.ax_heave.legend(loc="upper right")

        # Subscriber
        self.nav_sub = rospy.Subscriber(self.navstatus_topic, NavStatus,
                                        self.navstatus_callback, queue_size=10)
        self.trig_sub = rospy.Subscriber(self.trigger_topic, Rel_error_joystick,
                                         self.trigger_callback, queue_size=10)

    def trigger_callback(self, msg):
        """
        Callback del topic /relative_error (trigger di partenza).
        Al primo messaggio:
        - azzera i buffer
        - salva il tempo iniziale
        - abilita la registrazione
        """
        if not self.started:
            rospy.loginfo("Trigger ricevuto su %s: inizio registrazione/plot." % self.trigger_topic)
            with self.lock:
                self.started    = True
                self.start_time = rospy.get_time()
                self.times      = []
                self.depths     = []
                self.heaves     = []

    def navstatus_callback(self, msg):
        """
        Legge NavStatus e, se la registrazione è iniziata, salva:
        - depth
        - velocità di heave (ned_speed.z)
        """
        if not self.started or self.start_time is None:
            return

        now = rospy.get_time()
        t = now - self.start_time

        # ATTENZIONE:
        # Qui assumo:
        #   msg.depth         = profondità [m] positiva verso il basso
        #   msg.ned_speed.z   = velocità in Down (heave) [m/s]
        # Adatta se i nomi dei campi sono diversi!
        depth = msg.position.depth
        v_heave = msg.ned_speed.z

        with self.lock:
            self.times.append(t)
            self.depths.append(depth)
            self.heaves.append(v_heave)

    def spin(self):
        """
        Loop principale che aggiorna il plot.
        """
        rate = rospy.Rate(self.rate_hz)
        while not rospy.is_shutdown():
            with self.lock:
                if self.started and len(self.times) > 0:
                    t = self.times
                    d = self.depths
                    h = self.heaves

                    self.line_depth.set_xdata(t)
                    self.line_depth.set_ydata(d)

                    self.line_heave.set_xdata(t)
                    self.line_heave.set_ydata(h)

                    # Aggiorna limiti assi
                    self.ax_depth.relim()
                    self.ax_depth.autoscale_view()

                    self.ax_heave.relim()
                    self.ax_heave.autoscale_view()

                    self.fig.canvas.draw()
                    self.fig.canvas.flush_events()
            plt.pause(0.001)  # lascia respirare matplotlib
            rate.sleep()


if __name__ == "__main__":
    rospy.init_node("depth_heave_plotter")

    plotter = DepthHeavePlotter()
    try:
        plotter.spin()
    except rospy.ROSInterruptException:
        pass
    except KeyboardInterrupt:
        pass
