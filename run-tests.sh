#!/bin/bash
# Script de tests unifié pour Angular
# Génère un rapport JUnit XML dans test-results/

set -e  # Arrête le script si une commande échoue

echo "=========================================="
echo "🧪 Lancement des tests Angular"
echo "=========================================="

# Nettoyer les anciens rapports
echo "🧹 Nettoyage des anciens rapports..."
rm -rf test-results/
mkdir -p test-results/

# Vérifier que Node.js est installé
if ! command -v node &> /dev/null; then
    echo "❌ Erreur : Node.js n'est pas installé"
    exit 1
fi

echo "✅ Node.js version: $(node --version)"
echo "✅ npm version: $(npm --version)"

# Installer les dépendances si nécessaire
if [ ! -d "node_modules" ]; then
    echo "📦 Installation des dépendances npm..."
    npm ci --cache .npm --prefer-offline
else
    echo "✅ Dépendances déjà installées"
fi

# Lancer les tests
echo ""
echo "🧪 Exécution des tests Angular..."
npm test 2>&1 | tee test-results/test-output.log

# Vérifier que le rapport JUnit a été généré
if [ -f "test-results/junit.xml" ]; then
    echo ""
    echo "✅ Rapport JUnit généré : test-results/junit.xml"
    echo "📊 Résumé des tests :"
    grep -E "tests=|failures=|errors=" test-results/junit.xml || echo "Rapport disponible"
else
    echo "⚠️  Attention : Rapport JUnit non trouvé"
fi

echo ""
echo "=========================================="
echo "✅ Tests terminés avec succès"
echo "=========================================="

exit 0
