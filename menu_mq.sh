#!/bin/bash
# Programma creato da Claudio

# Dichiarazione delle variabili con i nomi dei QMgr
QMG1="LABS"
QMG2="MQREP1"
QMG3="MQREP2"
QMG4="BESTS"

# Variabili delle porte associate ai QMgr
PORTA_QMG1=1420
PORTA_QMG2=1431
PORTA_QMG3=1432
PORTA_BESTS=1415

# Variabiil delle Dead Letter Queue associati ai Qmgr
DQL1="SYSTEM.DEAD.LETTER.QUEUE"
DQL2="SYSTEM.DEAD.LETTER.QUEUE"
DQL3="SYSTEM.DEAD.LETTER.QUEUE"
DQL4="SYSTEM.DEAD.LETTER.QUEUE"

# Funzione per centrare il testo con colore
centra() {
    local testo="$1"
    local colore="$2"
    local cols=$(tput cols)
    local lunghezza=${#testo}
    local spazi=$(( (cols - lunghezza) / 2 ))

    if [ -n "$colore" ]; then
        printf "%*s\033[%sm%s\033[0m\n" "$spazi" "" "$colore" "$testo"
    else
        printf "%*s%s\n" "$spazi" "" "$testo"
    fi
}

# Funzione per controllare la versione di MQ
controllo_versione_mq() {
    echo -e "\033[36mControllo versione MQ...\033[0m"
    dspmqver 2>/dev/null || echo -e "\033[31mComando dspmqver non disponibile o MQ non installato.\033[0m"
}

# Controllo Qmgr attivo
controllo_qmgr() {
    echo -e "\n\033[36mControllo Qmgr attivo...\033[0m"
    dspmq
}

# Controllo listener attivo
controllo_listener() {
    echo -e "\n\033[36mControllo listener attivo...\033[0m"
    lsof -i | grep -i "LISTEN" | grep -i "mq"
}

# Controllo porta del listener
controllo_porta_listener() {
    echo -e "\n\033[36mControllo porta del listener...\033[0m"
    echo
    echo -e "\033[31mNome Qmgr: $QMG1\033[0m"
    netstat -tnlp | grep "$PORTA_QMG1"
    echo
    echo -e "\033[31mNome Qmgr: $QMG2\033[0m"
    netstat -tnlp | grep "$PORTA_QMG2"
    echo
    echo -e "\033[31mNome Qmgr: $QMG3\033[0m"
    netstat -tnlp | grep "$PORTA_QMG3"
    echo
    echo -e "\033[31mNome Qmgr: $QMG4\033[0m"
    netstat -tnlp | grep "$PORTA_BESTS"
    echo
}

# Controllo processi attivi 
controllo_processi() {
    echo -e "\n\033[36mControllo processi MQ attivi dei Qmgr\033[0m"
    echo
    echo -e "\033[31mNome Qmgr: $QMG1\033[0m"
    ps -ef | grep $QMG1 
    echo
    echo -e "\033[31mNome Qmgr: $QMG2\033[0m"
    ps -ef | grep $QMG2
    echo
    echo -e "\033[31mNome Qmgr: $QMG3\033[0m"
    ps -ef | grep $QMG3
    echo
    echo -e "\033[31mNome Qmgr: $QMG4\033[0m"
    ps -ef | grep $QMG4
    echo 
}

# Controllo code DLQ dei QMGR
controllo_code_dlq() {
    echo -e "\n\033[36mControllo delle Dead Letter Queue ...\033[0m"
    echo
    echo -e "\033[31mNome Qmgr: $QMG1\033[0m"
    echo "DISPLAY QSTATUS($DQL1) ALL" | runmqsc "$QMG1" 
    echo
    echo -e "\033[31mNome Qmgr: $QMG2\033[0m"
    echo "DISPLAY QSTATUS($DQL2) ALL" | runmqsc "$QMG2"
    echo
    echo -e "\033[31mNome Qmgr: $QMG3\033[0m"
    echo "DISPLAY QSTATUS($DQL3) ALL" | runmqsc "$QMG3" 
    echo
    echo -e "\033[31mNome Qmgr: $QMG4\033[0m"
    echo "DISPLAY QSTATUS($DQL4) ALL" | runmqsc "$QMG4" 
    echo
}

# Controllo log prodotto MQ (cat)
controllo_log_prodotto() {
    echo -e "\n\033[36mControllo log prodotto MQ...\033[0m"
    log_path="/var/mqm/errors"
    ls -l "$log_path"
    cat "$log_path"/AMQERR01.LOG 2>/dev/null || echo "Log non trovato."
}

# Controllo log Qmgr (cat)
controllo_log_qmgr() {
    echo -e "\n\033[36mControllo log Qmgr: $QMG1...\033[0m"
    log_path="/QM/BESTS/data/data/LABS/errors"
    ls -l "$log_path"
    cat "$log_path"/AMQERR01.LOG 2>/dev/null || echo "Log non trovato."
}

# Controllo spazio disco
controllo_spazio_disco() {
    echo -e "\n\033[36mControllo spazio disco...\033[0m"
    df -h
}

# Loop menu
while true; do
    clear
    centra "============ Controllo MQ ============" "34"
    echo
    echo "Seleziona un'opzione:"
    echo
    echo -e "\033[32m1) Controllo versione MQ\033[0m"
    echo -e "\033[32m2) Controllo Qmgr attivo\033[0m"
    echo -e "\033[32m3) Controllo listener attivo\033[0m"
    echo -e "\033[32m4) Controllo porta listener\033[0m"
    echo -e "\033[32m5) Controllo processi attivi QMGR\033[0m"
    echo -e "\033[32m6) Controllo delle code Dead Letter Queue\033[0m"
    echo -e "\033[32m7) Controllo log prodotto MQ\033[0m"
    echo -e "\033[32m8) Controllo log Qmgr\033[0m"
    echo -e "\033[32m9) Controllo spazio disco\033[0m"
    echo -e "\033[31m0) Esci\033[0m"
    echo
    read -p "Seleziona un'opzione: "
    echo

    case $REPLY in
        1) controllo_versione_mq ;;
        2) controllo_qmgr ;;
        3) controllo_listener ;;
        4) controllo_porta_listener ;;
        5) controllo_processi ;;
        6) controllo_code_dlq ;;
        7) controllo_log_prodotto ;;
        8) controllo_log_qmgr ;;
        9) controllo_spazio_disco ;;
        0) echo "Uscita..."; break ;;
        *) echo -e "\033[31mOpzione non valida.\033[0m" ;;
    esac
    echo
    read -p "Premi Invio per continuare..."
done
