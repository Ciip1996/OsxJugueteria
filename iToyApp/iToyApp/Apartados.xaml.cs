using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
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
    public sealed partial class Apartados : Page
    {
        public Apartados()
        {
            this.InitializeComponent();
            //CARGAR LISTA
            lstAp.ItemsSource = ApartadoHelper.consultarApartados();
        }
        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
        }
        int id; //ID GLOBAL PARA ELIMINAR
        //CONSULTAR REGISTRO SQLITE
        private void lstAp_Tapped(object sender, TappedRoutedEventArgs e)
        {
            Apartado miA = (sender as ListView).SelectedItem as Apartado;
            if (miA != null)
            {
                ApartadoHelper.consultaId(miA.Id);
                id = miA.Id;
            }

        }
        //ELIMINAR REGISTRO DE SQLITE
        private void appBarButton_Tapped(object sender, TappedRoutedEventArgs e)
        {
            ApartadoHelper.Eliminar(id);
            //CARGAR LISTA
            lstAp.ItemsSource = ApartadoHelper.consultarApartados();

        }
        private void btnMenu_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(MainPage));
        }
    }
       
}
