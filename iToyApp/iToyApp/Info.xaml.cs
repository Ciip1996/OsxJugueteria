using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Devices.Geolocation;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// La plantilla de elemento Página en blanco está documentada en http://go.microsoft.com/fwlink/?LinkID=390556

namespace iToyApp
{
    /// <summary>
    /// Página vacía que se puede usar de forma independiente o a la que se puede navegar dentro de un objeto Frame.
    /// </summary>
    public sealed partial class Info : Page
    {
        public Info()
        {
            this.InitializeComponent();
        }
        protected async override void OnNavigatedTo(NavigationEventArgs e)
        {
            var localizador = new Geolocator();
            //obtener un punto en el mapa
            localizador.DesiredAccuracyInMeters = 30;
            var nuevaPosicion = new Windows.Devices.Geolocation.BasicGeoposition();
            //asignamos los valores latitud, longitud.
            double lat = 21.151835788414925;
            double lon = -101.69473171234131;
            nuevaPosicion.Latitude = lat;
            nuevaPosicion.Longitude = lon;
            //convertir latitud y longitud en un punto
            var nuevoPunto = new Geopoint(nuevaPosicion);
            //asignar el punto al mapa
            await map.TrySetViewAsync(nuevoPunto, 16D);
            slider1.Value = map.ZoomLevel;
        }
        private void slider1_ValueChanged(object sender, RangeBaseValueChangedEventArgs e)
        {
            if (map != null)
                map.ZoomLevel = e.OldValue;
        }
        private void appBarButton_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(MainPage));
        }
    }
}
