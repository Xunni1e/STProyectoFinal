
# STProyectoFinal - Balanceo de Carga de Bases de Datos con MySQL y ProxySQL

Este proyecto implementa una arquitectura distribuida para bases de datos MySQL utilizando replicación Master-Slave y ProxySQL como balanceador de carga. El objetivo principal es optimizar el rendimiento, la disponibilidad y la tolerancia a fallos en sistemas que manejan múltiples consultas simultáneas.

---

## 📌 Objetivos

- Mejorar el rendimiento en operaciones de lectura y escritura.
- Asegurar la disponibilidad del servicio ante fallos de nodos.
- Simular un entorno real con balanceo de carga transparente para la aplicación.

---

## 🧩 Arquitectura

- **ProxySQL**: Proxy SQL-aware que enruta inteligentemente las consultas.
- **MySQL Master**: Maneja todas las operaciones de escritura (`INSERT`, `UPDATE`, `DELETE`).
- **MySQL Slaves (2)**: Réplicas configuradas para operaciones de solo lectura (`SELECT`).
- **Vagrant + VirtualBox**: Simulación de un entorno distribuido con 4 máquinas virtuales.

---

## 📁 Estructura del repositorio

```
STProyectoFinal/
├── scripts/             # Scripts de configuración para cada máquina
├── testdb.sql           # Base de datos de prueba con tabla y datos de ejemplo
├── Vagrantfile          # Define las máquinas virtuales y su red
└── .gitignore
```

---

## ⚙️ Instalación y ejecución

### 🔧 Requisitos

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- Git

### 🛠 Pasos

1. Clona el repositorio:

   ```bash
   git clone https://github.com/Xunni1e/STProyectoFinal.git
   cd STProyectoFinal
   ```

2. Levanta las máquinas virtuales:

   ```bash
   vagrant up
   ```

3. Accede a cada máquina con:

   ```bash
   vagrant ssh proxysql
   vagrant ssh mysqlmaster
   vagrant ssh mysqlslave1
   vagrant ssh mysqlslave2
   ```

4. Revisa los scripts de configuración en el directorio `scripts/`.

---

## 🧪 Pruebas realizadas

- **Lecturas**: Consultas `SELECT` fueron correctamente redirigidas a los Slaves.
- **Escrituras**: Consultas `INSERT`, `UPDATE`, `DELETE` se dirigieron al Master.
- **Pruebas de carga**: Se utilizó `sysbench` para simular múltiples consultas concurrentes.

---

## 💡 Resultados

- Se logró balancear la carga entre los nodos.
- El sistema respondió correctamente ante caídas de Slaves.
- El tiempo de respuesta mejoró significativamente en lecturas.

---

## 📚 Comparación con otras herramientas

Se comparó ProxySQL con:

- **HAProxy**: Buen rendimiento, pero sin soporte para entender SQL.
- **Balanceo desde la aplicación**: Funcional pero poco flexible y difícil de mantener.

---

## 🧠 Conclusión

ProxySQL demostró ser una solución eficiente y práctica para distribuir consultas, mejorar el rendimiento y asegurar tolerancia a fallos, todo sin necesidad de modificar el código fuente de la aplicación cliente.

---

## 👨‍💻 Autores

- Alfonso Miguel Hernández Guillen  
- Juan Sebastian Valderrama Tarapues  
- Esteban Marini Viteri  
- Ricardo Stiven Gonzalez Hernandez  
- Alex Guzman  

**Universidad Autónoma de Occidente**  
**Ingeniería Informática - Servicios Telemáticos**  
**2025-1S**
