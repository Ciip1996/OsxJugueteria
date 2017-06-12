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

// La plantilla de elemento Página en blanco está documentada en http://go.microsoft.com/fwlink/?LinkID=390556

namespace iToyApp
{
    /// <summary>
    /// Página vacía que se puede usar de forma independiente o a la que se puede navegar dentro de un objeto Frame.
    /// </summary>
    public sealed partial class File : Page
    {
        public File()
        {
            listadoArchivo();
            this.InitializeComponent();
        }

        /// <summary>
        /// Se invoca cuando esta página se va a mostrar en un objeto Frame.
        /// </summary>
        /// <param name="e">Datos de evento que describen cómo se llegó a esta página.
        /// Este parámetro se usa normalmente para configurar la página.</param>
        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
        }

        private async void button_Click(object sender, RoutedEventArgs e)
        {
            StorageFolder carpeta = ApplicationData.Current.LocalFolder;
            StorageFile archivo = await carpeta.CreateFileAsync(txtTitulo.Text + ".txt", CreationCollisionOption.ReplaceExisting);
            await FileIO.WriteTextAsync(archivo, txtContenido.Text);
            MessageDialog msb = new MessageDialog("Archivo creado correctamente.");
            listadoArchivo();
        }
        private async void listadoArchivo()
        {
            try
            {
                txtLista.Text = "";
                //Volvemos a acceder a la carpeta de nuestra app:
                StorageFolder local = ApplicationData.Current.LocalFolder;
                IReadOnlyList<StorageFile> archivos = await local.GetFilesAsync();
                foreach (StorageFile item in archivos)
                {
                    txtLista.Text += "\n" + item.Name;
                }
            }
            catch (Exception e)
            {
            }
        }

        private async void btnLeer_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string cadContenido = "";
                //Volvemos a acceder a la carpeta de nuestra app:
                StorageFolder local = ApplicationData.Current.LocalFolder;
                //Almacenamos en un flujo el contenido del archivo (si es que existe).
                Stream stream = await local.OpenStreamForReadAsync(txtTitulo.Text + ".txt");
                //Creamos un lector de stream para poder leer el contenido:
                using (StreamReader sr = new StreamReader(stream))
                {
                    cadContenido = sr.ReadToEnd();
                }
                txtContenido.Text = cadContenido;
            }
            catch (Exception )
            {
            }
        }

        private void btnMenu_Click(object sender, RoutedEventArgs e)
        {
            Frame.Navigate(typeof(MainPage));
        }
    }
}
