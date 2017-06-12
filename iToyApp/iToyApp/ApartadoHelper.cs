using SQLite;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.Storage;
//CLASE CON METODOS PARA CONTROLAR EL MODULO DE APARTADOS [SQLITE]
namespace iToyApp
{
    public class ApartadoHelper
    {
        //USO DE LOCAL SETTINGS
        public static bool cargarBD()
        {
            try
            {
                //crecar si el archivo existe USO DE [LOCAL SETTINGS]
                if (!checarExistencia("existe"))
                {
                    SQLiteConnection dbConn;
                    using (dbConn = new SQLiteConnection(App.DB_PATH))
                    {
                        dbConn.CreateTable<Apartado>();
                        var localSe = ApplicationData.Current.LocalSettings;
                        localSe.Values["existe"] = "ok";
                    }
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        public static bool checarExistencia(string pLlave)
        {
            var localSe = ApplicationData.Current.LocalSettings;
            return localSe.Values.ContainsKey(pLlave);
        }
        //INSERTAR EN SQLITE
        public static void insertar(Apartado pA)
            {
                using (var dbConn = new SQLiteConnection(App.DB_PATH))
                {
                    dbConn.RunInTransaction(() =>
                    {
                        dbConn.Insert(pA);
                    });
                }
            }
        //CONSULTAR APARTADOS
        public static ObservableCollection<Apartado> consultarApartados()
        {
            using (var dbConn = new SQLiteConnection(App.DB_PATH))
            {
                List<Apartado> lista = dbConn.Table<Apartado>().ToList<Apartado>();
                ObservableCollection<Apartado> obs = new ObservableCollection<Apartado>(lista);
                return obs;
            }
        }
       //CONSULTAR POR ID
        public static Apartado consultaId(int pId)
        {
            using (var dbConn = new SQLiteConnection(App.DB_PATH))
            {
                var ap = dbConn.Query<Apartado>("SELECT * FROM Apartado where Id = " + pId).FirstOrDefault();
                return ap;
            }
        }
        //ELIMINAR POR ID
        public static Apartado Eliminar (int pId)
        {
            using (var dbConn = new SQLiteConnection(App.DB_PATH))
            {
                var ap = dbConn.Query<Apartado>("DELETE FROM Apartado where Id = " + pId).FirstOrDefault();
                return ap;
            }
        }
    }
}
