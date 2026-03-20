// --- Script de Carga para el Modelo de Ocupación CREST ---
path = get_absolute_file_path('builder.sce');

// Ajuste de rutas
base_folder = path + 'Bloque_de_comportamientos/'; 
macros_path = base_folder + 'macros/';
ruta_paleta = path + 'Paleta_CREST.xpal'; // <-- Tu nueva paleta

// 1. Variable global para Python
global CREST_ROOT;
CREST_ROOT = base_folder;

// 2. Cargar la lógica matemática
genlib("OccupancyLib", macros_path);

// 3. Cargar la paleta visual en Xcos automáticamente
xcosPalLoad(ruta_paleta);

disp("-------------------------------------------");
disp("SUCCESS: Librerias y Paleta cargadas correctamente.");
disp("Abre Xcos y busca tu paleta en el menú de la izquierda.");
disp("-------------------------------------------");
