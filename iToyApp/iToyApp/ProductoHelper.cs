using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace iToyApp
{
    //METODOS PARA CONSUMIR WEB SERVICE
    public class ProductoHelper
    {
        //CONSULTA PRODUCTOS
        public async Task<HttpResponseMessage> obtenerProductos()
        {
            using (var producto = new HttpClient())
            {
                producto.BaseAddress = new Uri("http://localhost:55929/");
                producto.DefaultRequestHeaders.Accept.Clear();
                producto.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                return await producto.GetAsync("api/Productos");
            }
        }
        ////CONSULTA POR ID
        //public async Task<HttpResponseMessage> obtenerProducto(int pId)
        //{
        //    using (var producto = new HttpClient())
        //    {
        //        producto.BaseAddress = new Uri("http://localhost:56307/");
        //        producto.DefaultRequestHeaders.Accept.Clear();
        //        producto.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        //        return await producto.GetAsync("api/Productos/" + pId);
        //    }
        //}
    }
}
