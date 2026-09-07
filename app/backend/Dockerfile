FROM node:20-alpine 

WORKDIR /app

# Vá toàn bộ lỗ hổng bảo mật cấp hệ điều hành (libcrypto3, libssl3)
RUN apk update && apk upgrade --no-cache

# Cài đặt thư viện production 
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

COPY . .

# Chạy ứng dụng dưới quyền user 'node' (chuẩn bảo mật Shift-Left)
USER node

EXPOSE 3000
CMD ["node", "src/index.js"]