# =========================
# STAGE 1 — Build Angular
# =========================
FROM node:22-alpine AS build

WORKDIR /app

# Copier uniquement les fichiers nécessaires au npm install
COPY package.json package-lock.json ./

RUN npm ci

# Copier le reste du projet
COPY . .

# Build Angular en mode production
RUN npm run build

# =========================
# STAGE 2 — Nginx
# =========================
FROM nginx:1.27-alpine

# Supprimer la config par défaut
RUN rm /etc/nginx/conf.d/default.conf

# Copier la config nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier le build Angular
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
