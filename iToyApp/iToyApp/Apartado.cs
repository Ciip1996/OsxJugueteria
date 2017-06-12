using SQLite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iToyApp
{
    //TABLA DE BASE DE DATOS SQLITE
    public class Apartado
    {
        [PrimaryKey, AutoIncrement]
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Imagen { get; set; }
        public double Precio { get; set; }
        public int Cantidad { get; set; }
        public double Total { get; set; }
        public DateTime Fecha { get; set; }
    }
}
