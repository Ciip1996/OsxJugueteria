using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.Storage;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;


// La plantilla de elemento Página en blanco está documentada en http://go.microsoft.com/fwlink/?LinkId=391641

namespace iToyApp
{
    public sealed partial class MainPage : Page
    {
        public MainPage()
        {
            this.InitializeComponent();
            this.NavigationCacheMode = NavigationCacheMode.Required;
            ApartadoHelper.cargarBD();
            listadoArchivo();
        }
        MessageDialog msb;
        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
        }
        private void btnCatalogo_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(Catalogo));
        }
        private void btnApartados_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(Apartados));
        }
        private async void CrearArchivo()
        {
            try
            {
                string pFileName = txtTitulo.Text;
                string pContent = txtContenido.Text;
                StorageFolder carpeta = ApplicationData.Current.LocalFolder;
                StorageFile archivo = await carpeta.CreateFileAsync(pFileName + ".txt", CreationCollisionOption.ReplaceExisting);
                await FileIO.WriteTextAsync(archivo, pContent);
                msb = new MessageDialog("Nota Creada");
                await msb.ShowAsync();
            }
            catch(Exception e)
            {

            }
            listadoArchivo();
            txtTitulo.Text = "";
            txtContenido.Text = "";
        }
        private async void leerArchivo(string pNombre)
        {
            try
            {
                string cadContenido = "";
                StorageFolder local = ApplicationData.Current.LocalFolder;
                Stream stream = await local.OpenStreamForReadAsync(pNombre +".txt");
                using (StreamReader sr = new StreamReader(stream))
                {
                    cadContenido = sr.ReadToEnd();
                }
            }
            catch (Exception e)
            {
            }
        }
        private void btnGuardar_Click(object sender, RoutedEventArgs e)
        {
            CrearArchivo();
        }
        private void btnLeer_Click(object sender, RoutedEventArgs e)
        {
            leerArchivo(txtTitulo.Text);
        }
        private async void listadoArchivo()
        {
            try
            {
                //accedemos a la carpeta de nuestra app:
                StorageFolder local = ApplicationData.Current.LocalFolder;
                IReadOnlyList<StorageFile> archivos = await local.GetFilesAsync();
                foreach (StorageFile item in archivos)
                {
                    txtLista.Text += "\n" + item.Name;
                }
            }
            catch (Exception e)
            {
                // lblNoti.Text = "Error: " + e.Message;
            }
        }
        private void btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            fly.Hide();
        }

        private void btnInfo_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(Info));
        }

        private void btnfile_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(File));
        }
    }
}
