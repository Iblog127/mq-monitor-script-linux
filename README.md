# 🧪 MQ Monitor Script for Linux (IBM MQ on RHEL 9.5)

Uno script Bash interattivo per monitorare e diagnosticare l'ambiente **IBM MQ** su sistemi Linux, in particolare **Red Hat Enterprise Linux 9.5**.

✅ Progettato per gestire **più queue manager (QMgr)** in un unico script.  
✅ Creato per un uso pratico e quotidiano da parte di sistemisti e operatori MQ.

---

## 📋 Funzionalità principali

- Verifica la versione installata di IBM MQ
- Controlla lo stato dei queue manager
- Verifica listener attivi e porte configurate
- Monitora i processi MQ attivi per ogni QMgr
- Controlla le **Dead Letter Queue**
- Analizza i log sia del prodotto MQ che dei QMgr specifici
- Verifica lo spazio disco disponibile
- Menu interattivo a colori per un'esperienza semplice e intuitiva

---

## 🧰 Requisiti

- Sistema operativo: Linux (testato su Red Hat Enterprise Linux 9.5)
- IBM MQ installato e configurato
- Comandi disponibili: `dspmq`, `runmqsc`, `netstat`, `lsof`, `ps`, `df`, `cat`
- Accesso ai log in `/var/mqm/errors` e alle directory dati dei QMgr

---

## 🚀 Come usarlo

1. Clona il repository o scarica lo script:

```bash
git clone https://github.com/iblog127/mq-monitor-script-linux.git
cd mq-monitor-script-linux
chmod +x mq_monitor.sh
