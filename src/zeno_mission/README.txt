L'architettura software del progetto è suddivisa in fasi sequenziali. Affinché il sistema operi correttamente, 
è necessario eseguire i nodi rispettando l'ordine indicato, in quanto ogni fase genera i file di configurazione 
necessari a quella successiva.

###########################################  FASE 0  ############################################

Questa fase è dedicata al setup dell'ambiente operativo e alla generazione della traiettoria di copertura. 
Si compone di due step:
    1. Generazione della Safezone
        Il nodo phase0_polygon_ini.py legge le coordinate nominali dell'area dal file safezone.txt. 
        Il sistema definisce l'origine geodetica locale (NED), costruisce il poligono originale
        e calcola internamente un poligono ristretto di sicurezza (safezone). 
        I parametri risultanti vengono salvati sul file region_params.yaml. 
        I grafici generati vengono salvati automaticamente nella cartella img/.
        Per avviare questo nodo, eseguire:
                rosrun zeno_mission phase0_polygon_ini.py

    2. Generazione del Coverage Path
        Il nodo phase0_coverage_planner.py estrae i vertici della safezone dal server e calcola i 
        waypoint necessari per una navigazione a tagliaerba (lawnmower). 
        La spaziatura dei transetti è calcolata dinamicamente per ottimizzare l'impronta dei sensori acustici. 
        I waypoint finali vengono scritti nel file waypoint_phase1.yaml e viene generato un plot visivo 
        del percorso.
        Per avviare la pianificazione, eseguire:                
                roslaunch zeno_mission zeno_phase0.launch

###########################################  FASE 1  ############################################

In questa fase si avvia il controllo cinematico del veicolo.

Il nodo phase1_pure_pursuit_controller acquisisce l'ambiente e i waypoint generati in Fase 0. 
Prima di attivare i motori, l'algoritmo ordina i waypoint agganciando automaticamente il nodo 
più vicino alla posizione attuale di Zeno, per poi dare inizio all'inseguimento della traiettoria.
A schermo viene mostrata un'animazione per il monitoraggio visivo in tempo reale, mentre il 
terminale è riservato ai soli messaggi di stato (inizio/fine) e ad eventuali errori. 
La telemetria in tempo reale viene pubblicata costantemente sul topic /phase1/telemetry

Per avviare la missione operativa, aprire due terminali separati ed eseguire in sequenza:

    1. Avvio Simulatore Zeno: 
            roslaunch zeno_sim_pkg zeno.launch

    2. Avvio Controllore:          
            roslaunch zeno_mission zeno_phase1.launch  

###########################################  FASE 3  ############################################
In questa fase il sistema gestisce la navigazione su percorsi non strutturati,
con l'obiettivo di raggiungere i bersagli d'interesse (boe) ed evitare le zone
di interdizione (tubi).

LETTURA CONFIGURAZIONI: Il sistema carica le posizioni geometriche di target
e ostacoli leggendole direttamente dai file dedicati presenti nella cartella
'config/': "targets.yaml" e "obstacles.yaml".

PIANIFICAZIONE: Il nodo pianificatore (A*) calcola il percorso ottimale per
evitare gli ostacoli e pubblica la lista dei waypoint di manovra sul topic /waypoint_path.

Per avviare la missione operativa, aprire due terminali separati ed eseguire in sequenza:

    1. Avvio Simulatore Zeno:
            roslaunch zeno_sim_pkg zeno.launch

    2. Avvio Controllore:          
            roslaunch zeno_mission zeno_phase3.launch  


#########################################  LOG E RISULATI  ##########################################
Alla fine di ogni fase di missione, il sistema si occupa di preservare i dati:

    CARTELLA 'logs/' (Scatola Nera):
    Il controllore genera un file CSV univoco (indicizzato con timestamp di data
    e ora) contenente tutta la telemetria di missione. Il salvataggio dei dati è
    garantito automaticamente anche in caso di interruzione forzata dello script.
    Si raccomanda agli utenti di rinominare i log di interesse aggiungendo un
    commento testuale finale sull'esito della specifica esecuzione.

    CARTELLA 'results/':
    Questa cartella contiene le liste unificate prodotte durante l'esperimento 
    ai laghetti di Campo.
    
    Cartella 'BAG':
    Contiene le BAG delle diverse fasi svolte durante l'esperimento ai laghetti 
    di Campo. 
