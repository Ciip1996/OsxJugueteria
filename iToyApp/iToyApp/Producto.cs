using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iToyApp
{
    //CLASE PRODUCTO PARA CONSUMIR WEB SERVICE
    public class Producto
    {
        public int cantidad { get; set; }
        public string descripcion { get; set; }
        public int edadMaxima { get; set; }
        public int edadMinima { get; set; }
        public int idProducto { get; set; }
        public string marca { get; set; }
        public string nombre { get; set; }
        public float precioVenta { get; set; }
    }
}
