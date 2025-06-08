# 🛒 Infrastructure PrestaShop Dockerisée - Projet de Cours

## 📖 Description

Projet de cours : Infrastructure complète de production pour PrestaShop, entièrement conteneurisée avec Docker et orchestrée avec Docker Compose. Cette plateforme intègre un reverse proxy, une base de données persistante, un monitoring complet, un système d'alertes, un pipeline CI/CD et un système de backup automatique.

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Users/Web     │    │   Monitoring    │    │   CI/CD         │
│                 │    │                 │    │                 │
│ HTTP:80         │    │ Grafana:3000    │    │ GitHub Actions  │
└─────────┬───────┘    │ Prometheus:9090 │    │                 │
          │            │ AlertManager    │    └─────────────────┘
          ▼            └─────────────────┘
┌─────────────────┐
│ NGINX (Reverse  │
│ Proxy)          │
│ Port: 80        │
└─────────┬───────┘
          │
          ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   PrestaShop    │    │     MySQL       │    │   phpMyAdmin    │
│   Application   │◄──►│   Database      │◄──►│   Management    │
│   Port: 80      │    │   Port: 3306    │    │   Port: 8080    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌─────────────────┐
                       │ Backup Service  │
                       │ (Cron: 6h)      │
                       │ Rotation: 12    │
                       └─────────────────┘
```

## 🚀 Services déployés

### Application Stack

- **PrestaShop** : E-commerce application
- **MySQL** : Base de données avec persistance
- **phpMyAdmin** : Interface de gestion DB
- **NGINX** : Reverse proxy

### Monitoring Stack

- **Prometheus** : Collecte de métriques
- **Grafana** : Dashboard et visualisation
- **cAdvisor** : Monitoring des conteneurs
- **Node Exporter** : Métriques système
- **AlertManager** : Gestion des alertes

### Services Support

- **Backup** : Sauvegarde automatique MySQL (toutes les 6h)
- **CI/CD** : GitHub Actions pour build et déploiement

## 📋 Prérequis

- Docker 20.10+
- Docker Compose 2.0+
- 4 GB RAM minimum
- 10 GB espace disque

## 🛠️ Installation Rapide

### 1. Cloner le repository

```bash
git clone https://github.com/fabienlpt/docker-prestashop.git
cd docker-prestashop
```

### 2. Configurer les variables d'environnement

```bash
cp .env.example .env
# Modifier .env si nécessaire (optionnel pour les tests)
```

### 3. Démarrer l'infrastructure

```bash
# Construire et démarrer tous les services
docker compose up -d

# Vérifier le statut
docker compose ps
```

## 🌐 Accès aux interfaces

| Service        | URL                   | Identifiants     |
| -------------- | --------------------- | ---------------- |
| **PrestaShop** | http://localhost      | Setup à faire    |
| **Grafana**    | http://localhost:3000 | admin / admin123 |
| **phpMyAdmin** | http://localhost:8080 | root / root      |
| **Prometheus** | http://localhost:9090 | -                |
| **cAdvisor**   | http://localhost:8081 | -                |

## 🔐 Connexion au Back-Office PrestaShop

### Accès administrateur

- **URL** : http://localhost/admin/
- **Email** : `demo@prestashop.com`
- **Mot de passe** : `prestashop_demo`

## 💾 Système de Backup

### Gestion des backups

```bash
# Créer un backup immédiat
./backup-manager.sh backup

# Lister les backups disponibles
./backup-manager.sh list

# Restaurer un backup
./backup-manager.sh restore <nom_fichier>

# Voir les logs de backup
./backup-manager.sh logs
```

### Configuration automatique

- **Fréquence** : Toutes les 6 heures
- **Rotation** : 12 derniers backups (3 jours)
- **Format** : SQL compressé (.sql.gz)

## 📊 Monitoring

Le dashboard Grafana inclut :

- CPU/RAM du système
- Métriques des conteneurs
- Uptime des applications
- Alertes automatiques

## 🔒 Sécurité

- ✅ Utilisateurs non-root dans tous les conteneurs
- ✅ Réseaux Docker séparés (prestashop_network, monitoring_network)
- ✅ Variables sensibles dans .env
- ✅ Exposition minimale des ports

## 🔄 CI/CD Pipeline

Le workflow GitHub Actions automatise :

- Build des images Docker personnalisées
- Push vers Docker Hub
- Tests de base

## 🛠️ Commandes utiles

```bash
# Démarrer/Arrêter
docker compose up -d
docker compose down

# Voir les logs
docker compose logs -f [service_name]

# Rebuild un service
docker compose build [service_name]
docker compose up -d [service_name]

# Nettoyer
docker system prune -a
```

## 📚 Structure du projet

```
docker-prestashop/
├── .env.example                  # Variables d'environnement exemple
├── docker-compose.yml            # Orchestration principale
├── backup-manager.sh             # Script de gestion backup
├── README.md                     # Cette documentation
├── .github/workflows/            # Pipeline CI/CD
├── prestashop/                   # Image PrestaShop personnalisée
│   ├── Dockerfile
│   └── php.ini
├── nginx/                        # Reverse proxy
│   ├── Dockerfile
│   └── nginx.conf
├── backup/                       # Système de backup
│   ├── Dockerfile
│   ├── backup.sh
│   ├── restore.sh
│   └── start-backup.sh
└── monitoring/                   # Stack de monitoring
    ├── prometheus.yml
    ├── alertmanager.yml
    ├── alert-rules.yml
    └── grafana/provisioning/
```

## 🧪 Tests et Validation

1. **Vérifier tous les services** : `docker compose ps`
2. **Tester PrestaShop** : Accéder à http://localhost
3. **Vérifier le monitoring** : Dashboard Grafana sur http://localhost:3000
4. **Tester le backup** : `./backup-manager.sh backup`
5. **Vérifier les alertes** : Simuler une charge CPU

## 🐛 Dépannage

**Services qui ne démarrent pas :**

```bash
docker compose logs [service_name]
docker system df
```

**Backup échoue :**

```bash
./backup-manager.sh logs
docker exec backup /usr/local/bin/backup.sh
```

**Monitoring inaccessible :**

```bash
docker compose restart prometheus grafana
```

## 📝 Notes pour le cours

### Points couverts par ce projet :

- ✅ Conteneurisation complète avec Docker
- ✅ Orchestration avec Docker Compose
- ✅ Reverse proxy NGINX
- ✅ Base de données MySQL avec persistance
- ✅ Monitoring complet (Prometheus/Grafana)
- ✅ Système d'alertes
- ✅ Pipeline CI/CD
- ✅ Backup automatique avec rotation
- ✅ Sécurité (utilisateurs non-root, réseaux isolés)
- ✅ Variables d'environnement
- ✅ Scripts d'automatisation

### Commandes de démonstration :

```bash
# Démo complète
docker compose up -d
./backup-manager.sh backup
./backup-manager.sh list
curl http://localhost
curl http://localhost:3000
```
