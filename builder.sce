// --- Script de Carga para el Modelo de Ocupación CREST ---
path = get_absolute_file_path('builder.sce');

// Ajuste de rutas
base_folder = path + 'Bloque_de_comportamientos/'; 
macros_path = base_folder + 'macros/';

// 1. Definir la variable global para que la simulación encuentre Python
global CREST_ROOT;
CREST_ROOT = base_folder;

// 2. Cargar la lógica matemática (Sin paletas gráficas)
genlib("OccupancyLib", macros_path);

disp("-------------------------------------------");
disp("SUCCESS: Librerias cargadas correctamente.");
disp("Ya puedes abrir el archivo Ocupation_simulation.zcos en Xcos.");
disp("-------------------------------------------");
