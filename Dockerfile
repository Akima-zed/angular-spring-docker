# Étape 1 : Compiler l'application Angular
# Utilise Node.js 22 pour installer les dépendances et compiler TypeScript → JavaScript
FROM node:22-alpine AS build

WORKDIR /app

# Copie les fichiers de dépendances npm
COPY package.json package-lock.json ./

# Installe les dépendances (npm ci = version exacte du package-lock.json)
RUN npm ci

# Copie le code source Angular
COPY . .

# Compile Angular → Crée le dossier dist/ avec les fichiers HTML/CSS/JS optimisés
RUN npm run build

# Étape 2 : Servir l'application avec Nginx
# Utilise Nginx (serveur web léger) pour servir les fichiers statiques
FROM nginx:1.27-alpine

# Supprime la configuration Nginx par défaut
RUN rm /etc/nginx/conf.d/default.conf

# Copie notre configuration Nginx personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copie les fichiers compilés depuis l'étape 1 (dans le dossier browser d'Angular 18+)
COPY --from=build /app/dist/olympic-games-starter/browser /usr/share/nginx/html

# Port utilisé par Nginx
EXPOSE 80

# Commande pour lancer Nginx en premier plan
CMD ["nginx", "-g", "daemon off;"]
