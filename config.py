# Clase base para la configuración de la aplicación
class Config:
    # Clave secreta para la seguridad de la aplicación (por ejemplo, para manejar sesiones)
    SECRET_KEY = 'B!1w8NAt1T^%kvhUI*S^'


# Clase de configuración para el entorno de desarrollo
class DevelopmentConfig(Config):
    # Habilitar el modo de depuración (debug) para obtener mensajes de error detallados
    DEBUG = True
    # Configuración de la base de datos MySQL
    MYSQL_HOST = 'localhost'  # Host de la base de datos
    MYSQL_USER = 'root'       # Usuario de la base de datos
    MYSQL_PASSWORD = ''       # Contraseña de la base de datos (vacía en este caso)
    MYSQL_DB = 'restaurante_cun'  # Nombre de la base de datos


# Diccionario que mapea el entorno de configuración a la clase correspondiente
config = {
    'development': DevelopmentConfig  # Configuración para el entorno de desarrollo
}