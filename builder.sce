// Script para cargar todo automáticamente
path = get_absolute_file_path('builder.sce');
macros_path = path + '/Ocupancy_Model_Block/macros';
scripts_path = path + '/Ocupancy_Model_Block/scripts';

// Cargar macros
genlib("OccupancyLib", macros_path);

// Ejecutar script principal si existe
exec(scripts_path + '/Ocupancy_Model.sce');

disp("Occupancy Model Block loaded successfully!");
