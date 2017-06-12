using System;
using System.Collections.Generic;
using System.Net.Http;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Navigation;
using Newtonsoft.Json;

// La plantilla de elemento Página en blanco está documentada en http://go.microsoft.com/fwlink/?LinkID=390556

namespace iToyApp
{
    public sealed partial class Catalogo : Page
    {
        public Catalogo()
        {
            this.InitializeComponent();
            refrescarLista(); //CARGAR LISTA DE PRODUCTOS WEBSERVICE
            medUno.Source = new Uri("ms-appx:///Assets/toy.mp3", UriKind.Absolute);
            medUno.Play();
        }
        ProductoHelper c;
        MessageDialog msgbox;
        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
        }
        //CONSULTA WEB SERVICE TRAE EL RESUTADO EN JSON
        private async void refrescarLista()
        {
            c = new ProductoHelper();
            HttpResponseMessage response = await c.obtenerProductos();
            if (response.IsSuccessStatusCode)
            {
                String responseContent = await response.Content.ReadAsStringAsync();
                List<Producto> produc = JsonConvert.DeserializeObject<List<Producto>>(responseContent);
                lstProductos.ItemsSource = produc;
            }
        }
        //CONSULTA WEB SERVICE POR ID DESERIALIZAR JSON
        double total;
        double precio;
        string nombre;
        private void lstProductos_Tapped(object sender, TappedRoutedEventArgs e)
        {
            Producto p = (sender as ListView).SelectedItem as Producto;
            if (p != null)
            {
                txtDescripcion.Text = "";
                txtDescripcion.Text = p.descripcion + "\n Edad Minima: " + p.edadMinima + "\n Edad Maxima: " + p.edadMaxima;
                if (txtCantidad.Text != "")
                {
                    precio = p.precioVenta;
                    nombre = p.nombre;
                    total = double.Parse(txtCantidad.Text) * (p.precioVenta);
                    txtTotal.Text = "$" + total.ToString();
                }
            }
        }
        //INSERTA REGISTRO EN SQLITE
        private async void btnApartar_Click(object sender, RoutedEventArgs e)
        {
            if (txtCantidad.Text == "0")
            {
                msgbox = new MessageDialog("La cantidad debe ser mayor a 0");
                await msgbox.ShowAsync();
            }
            else if (txtCantidad.Text != "" || txtDescripcion.Text != "")
            {
                Apartado a = new Apartado();
                a.Nombre = nombre;
                a.Precio = precio;
                a.Cantidad = int.Parse(txtCantidad.Text);
                a.Fecha = DateTime.Now;
                a.Total =total;   
                a.Imagen= "ms-appx:///Assets/osito.png";
                ApartadoHelper.insertar(a);
                msgbox = new MessageDialog("Se ha apartado su Producto");
                await msgbox.ShowAsync();
            }
            else
            {
                msgbox = new MessageDialog("LLene todos los campos");
            }
        }
        private void txtCantidad_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (txtCantidad.Text != "")
            {
                total = double.Parse(txtCantidad.Text) * (precio);
                txtTotal.Text = "$" + total.ToString();
            }
        }
        private void btnMenu_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(MainPage));
        }
        //Pausar Musica
        private void btnPlay_Click(object sender, RoutedEventArgs e)
        {
            medUno.Pause();
            btnMute.IsEnabled=true;
            btnPlay.IsEnabled = false;
        }
        //Reproducir Musica
        private void btnMute_Click(object sender, RoutedEventArgs e)
        {
            medUno.Play();
            btnMute.IsEnabled = false;
            btnPlay.IsEnabled = true;
        }
    }
}
