//
//  AppDelegate.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 04/04/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "AppDelegate.h"
#import "AlimentadorInventarioVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

//este siguiente codigo disque es para tener la variable global.
@synthesize EmpleadoSesionActivo;

static AppDelegate *instance = nil;
+(AppDelegate *)getInstance{
    @synchronized(self){
        if(instance==nil){
            instance= [AppDelegate new];
        }
    }
    return instance;
}


-(id) init{
    //Ruta para la base de datos, estara en la library que es privada, ya que Documents se comparte con el usuario mediante Itunes
    NSArray *paths  =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *LibraryDirectory  =  [paths objectAtIndex:0];
        //Añadimos el nombre del fichero de la base de datos
    self.databasepath = [LibraryDirectory stringByAppendingPathComponent:@"JugueteriaBD.db"];
        //cargo la base de datos
    [self loadDB];
    return self;
}
-(void) MessageBox:(NSString *)Message andTitle:(NSString *)titulo{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Continuar"];
    [alert setMessageText:titulo];
    [alert setInformativeText:Message];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert runModal];
}
-(void) loadDB{
    BOOL exito;
    NSFileManager  *filemanager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory  = [paths objectAtIndex:0];
    NSString *writetableDBPath = [libraryDirectory stringByAppendingPathComponent:@"JugueteriaBD.db"];
    exito = [filemanager fileExistsAtPath:writetableDBPath];
    if (exito) return;
    //si no existe en Library, la copio desde original.
    NSString *defaulDBPath  = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"JugueteriaBD.db"];//archivo del proyecto
    exito  = [filemanager copyItemAtPath:defaulDBPath toPath:writetableDBPath error:&error];
    if (!exito)
    {
        NSAssert1(0,@"Error al cargar la base de datos, error = '%@'. ", [error localizedDescription]);
    }
}
-(void) replicarBD{
    BOOL exito;
    NSFileManager  *filemanager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory  = [paths objectAtIndex:0];
    NSString *writetableDBPath = [libraryDirectory stringByAppendingPathComponent:@"JugueteriaBD.db"];
    exito = [filemanager fileExistsAtPath:writetableDBPath];
    if (exito) return;
    NSString *proyectDBPath  = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"JugueteriaBD.db"];//archivo del proyecto
    exito  = [filemanager copyItemAtPath:writetableDBPath toPath:proyectDBPath error:&error];
    if (!exito)
    {
        NSAssert1(0,@"Error al cargar la base de datos, error = '%@'. ", [error localizedDescription]);
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    }
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    /*
    //Valido si existe la base de datos en library.
    BOOL exito;
    NSError *error;
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSFileManager  *filemanager = [NSFileManager defaultManager];
    
    NSString *directorioLibreria  = [paths objectAtIndex:0];
    NSString *directorioBdEnLibreria = [directorioLibreria stringByAppendingPathComponent:@"JugueteriaBD.db"];
    exito = [filemanager fileExistsAtPath:directorioBdEnLibreria];
    if (exito){
        //si existe entonces la copio a la base de datos de mi carpeta de archivos. Pero primero hay que borrar el archivo que esta ahi si existe.
        NSString *PathBDLocalProyecto  = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"JugueteriaBD.db"];//obtengo el path del archivo de proyecto sqlite.
        ProductoViewController *PVC = [[ProductoViewController alloc]init];
        if ([filemanager fileExistsAtPath: PathBDLocalProyecto])
        {
            //Eliminar archivo
            if (![filemanager removeItemAtPath:PathBDLocalProyecto error:&error])
            {
                [PVC MessageBox:[error localizedDescription] andTitle:@"Error al guardar"];
            }
            else
            {
                BOOL correcto = [filemanager copyItemAtPath:directorioBdEnLibreria toPath:PathBDLocalProyecto error:&error];//copia y pega en carpeta de proyecto
                if (correcto)
                {
                    [PVC MessageBox:@"Se guardaron los datos con exito." andTitle:@"Guardado Finalizado"];
                }
                else{
                    [PVC MessageBox:[error localizedDescription] andTitle:@"Error al salvar cambios SQLite."];
                }
            }
        }
    }*/
}

@end
