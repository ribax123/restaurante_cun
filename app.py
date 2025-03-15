from flask import Flask, flash, redirect, render_template, request, url_for
from flask_mysqldb import MySQL
from config import config
from flask import session
from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash

# Inicialización de la aplicación Flask
app = Flask(__name__)
# Configuración de la aplicación desde el archivo de configuración
app.config.from_object(config['development'])

# Inicialización de la extensión MySQL para Flask
mysql = MySQL(app)

# Función para obtener menús por tipo
def obtener_menus_por_tipo(tipo_menu):
    cur = mysql.connection.cursor()
    query = "SELECT id, nombre, ingredientes FROM menus WHERE tipo_menu = %s"
    cur.execute(query, (tipo_menu,))
    menus = cur.fetchall()
    cur.close()
    return menus

# Ruta para mostrar menús por tipo
@app.route('/menus/<tipo>')
def mostrar_menus(tipo):
    menus = obtener_menus_por_tipo(tipo)
    return render_template('menus.html', menus=menus, tipo=tipo)

# Ruta para la página de inicio
@app.route('/') 
def home():
    return render_template('index.html')

# Ruta para la página de servicios
@app.route('/servicios') 
def servicios():
    return render_template('servicios.html')

# Ruta para la página "Quiénes Somos"
@app.route('/quienes-somos') 
def quienes_somos():
    return render_template('quienes_somos.html')

# Ruta para la página de contacto
@app.route('/contacto') 
def contacto():
    return render_template('contacto.html')

# Ruta para la página de login
@app.route('/login')
def login():
    return render_template('login.html')

# Ruta para guardar un pedido
@app.route('/guardar_pedido', methods=['POST'])
def guardar_pedido():
    if request.method == 'POST':
        # Obtener los datos del formulario
        menu_nombre = request.form['menu_nombre']
        nombre_comensal = request.form['nombre_comensal']
        cedula_comensal = request.form['cedula_comensal']
        correo_comensal = request.form['correo_comensal']
        telefono_comensal = request.form['telefono_comensal']
        cantidad = int(request.form['cantidad'])
        tipo_consumo = request.form['tipo_consumo']
        numero_mesa = request.form.get('numero_mesa')
        comentarios = request.form['comentarios']

        try:
            # Insertar el pedido en la base de datos
            cur = mysql.connection.cursor()
            cur.execute("""
                INSERT INTO pedidos (menu_nombre, nombre_comensal, cedula, correo_comensal, telefono_comensal, cantidad, tipo_consumo, numero_mesa, comentarios)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (menu_nombre, nombre_comensal, cedula_comensal, correo_comensal, telefono_comensal, cantidad, tipo_consumo, numero_mesa, comentarios))
            mysql.connection.commit()
            cur.close()
            flash('¡Pedido registrado con éxito!', 'success')
        except Exception as e:
            print('Error al guardar pedido:', e)
            flash('Error al guardar el pedido.', 'danger')

        return redirect(request.referrer)

# Ruta para el login del administrador
@app.route('/login_admin', methods=['POST'])
def login_admin():
    usuario = request.form['usuario']
    clave = request.form['clave']

    try:
        # Verificar las credenciales del administrador
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM admin WHERE usuario = %s", (usuario,))
        admin = cur.fetchone()
        cur.close()

        if admin and check_password_hash(admin[2], clave):
            session['admin_logged'] = True
            flash('¡Inicio de sesión exitoso!', 'success')
            return redirect('/admin')
        else:
            flash('Usuario o clave incorrectos.', 'danger')
            return redirect('/login')

    except Exception as e:
        print("Error en login:", e)
        flash('Error al procesar el login.', 'danger')
        return redirect('/login')

# Ruta para el panel de administración
@app.route('/admin')
def admin():
    if not session.get('admin_logged'):
        flash('Debes iniciar sesión como administrador.', 'warning')
        return redirect('/login')

    try:
        # Obtener todos los pedidos ordenados por ID de forma descendente
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM pedidos ORDER BY id DESC")
        pedidos = cur.fetchall()
        cur.close()
        return render_template('admin.html', pedidos=pedidos)
    except Exception as e:
        print("Error al cargar pedidos:", e)
        flash('Error al cargar los pedidos.', 'danger')
        return redirect('/login')

# Ruta para cerrar sesión
@app.route('/logout')
def logout():
    session.pop('admin_logged', None)
    flash('Sesión cerrada.', 'info')
    return redirect('/login')

# Ruta para crear un administrador (solo para uso interno)
@app.route('/crear_admin')
def crear_admin():
    usuario = 'admincun'
    clave = '12345678'
    clave_hash = generate_password_hash(clave)

    try:
        # Insertar un nuevo administrador en la base de datos
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO admin (usuario, clave) VALUES (%s, %s)", (usuario, clave_hash))
        mysql.connection.commit()
        cur.close()
        return 'Admin creado con éxito'
    except Exception as e:
        return f'Error: {e}'

# Ruta para eliminar un pedido
@app.route('/eliminar_pedido/<int:id_pedido>', methods=['POST'])
def eliminar_pedido(id_pedido):
    try:
        # Eliminar un pedido por su ID
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM pedidos WHERE id = %s", (id_pedido,))
        mysql.connection.commit()
        flash('Pedido eliminado correctamente', 'success')
    except Exception as e:
        print(f"Error al eliminar pedido: {e}")
        flash('Error al eliminar el pedido', 'danger')
    return redirect(url_for('admin'))  # Redirige al panel de administración

# Ruta para actualizar un pedido
@app.route('/actualizar_pedido/<int:id_pedido>', methods=['POST'])
def actualizar_pedido(id_pedido):
    # Obtener los datos del formulario
    menu_nombre = request.form['menu_nombre']
    nombre_comensal = request.form['nombre_comensal']
    correo_comensal = request.form['correo_comensal']
    telefono_comensal = request.form['telefono_comensal']
    cantidad = request.form['cantidad']
    comentarios = request.form['comentarios']
    cedula = request.form['cedula']
    tipo_consumo = request.form['tipo_consumo']
    numero_mesa = request.form['numero_mesa']

    try:
        # Actualizar el pedido en la base de datos
        cur = mysql.connection.cursor()
        cur.execute("""
            UPDATE pedidos
            SET menu_nombre = %s,
                nombre_comensal = %s,
                correo_comensal = %s,
                telefono_comensal = %s,
                cantidad = %s,
                comentarios = %s,
                cedula = %s,
                tipo_consumo = %s,
                numero_mesa = %s
            WHERE id = %s
        """, (menu_nombre, nombre_comensal, correo_comensal, telefono_comensal, cantidad, comentarios, cedula, tipo_consumo, numero_mesa, id_pedido))
        mysql.connection.commit()
        flash('Pedido actualizado correctamente', 'success')
    except Exception as e:
        print(f"Error al actualizar pedido: {e}")
        flash('Error al actualizar el pedido', 'danger')
    return redirect(url_for('admin'))  # Redirige al panel de administración

# Punto de entrada de la aplicación
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=7272)