# Elite Manager APP Móvil


## Instalación

- Para ejecutar el proyecto es necesario tener instalado GIT y el SDK de Flutter

- Antes de ejecutar el proyecto se debe ejecutar un comando para traer las librerias utilizadas en el programa, utilizaremos el siguiente comando en la consola
```bash
   flutter pub get
```
- Luego de terminar de instalar los requerimientos se deberá acceder al directorio del proyecto y configurar el config.dart
```bash
   class Configuracion {
  static  String appName = "Elite Manager";
  static  String apiurl = '192.x.x.x'; // cambiar por su ip (ipconfig en cmd)
  static  const loginAPI = "Api/login/";
  static  const obtenertokenAPI = "Api/api-token-auth/";
  static  String superuser = "abcde:12345"; // cambiar por superusuario creado en db django
}
``` 
- Para ejecutar la aplicación es necesario tener corriendo un dispositivo virtual, y presionar F5 para lanzar la aplicación

- Dependerá del back la creación de proveedores y asignar esos proveedores a diversos insumos, se puede acceder desde Django ADMIN
## Referencias para probar la API

#### Obtener los usuarios

```http
  GET /Api/user/
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `basic auth` | `authorization` | **Requerido**. SuperUser |

#### Probar el Login, debe devolver el token

```http
  POST /Api/login/
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `username`      | `string` | **Requerido**. Pasar el username por Body |
| `password`      | `string` | **Requerido**. Pasar el password por el Body |

#### Obtener el Token y el user ID

```http
  POST /Api/api-token-auth/
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `username`      | `string` | **Requerido**. Pasar el username por Body |
| `password`      | `string` | **Requerido**. Pasar el password por el Body |

## Autores

- [@Ignacio Faundes](https://github.com/negalxd)
- [@Benjamín Flores](https://github.com/Benjaxdddd)



 
