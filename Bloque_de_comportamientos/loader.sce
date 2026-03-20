// --- Archivo: loader.sce ---
// Este script carga el toolbox y lo prepara para cualquier ordenador

try
    // 1. Detectar la ruta absoluta dinámicamente
    ruta_actual = get_absolute_file_path("loader.sce");
    
    // 2. Guardar la ruta en una variable global para que los bloques la usen
    global CREST_ROOT;
    CREST_ROOT = ruta_actual;
    
    // 3. Cargar las funciones (macros)
    disp("Cargando macros de CREST...");
    ruta_macros = ruta_actual + "macros" + filesep();
    genlib("crest_lib", ruta_macros);
    
    // 4. Cargar la paleta en Xcos (Opcional pero muy recomendado)
    // xcosPalAddBlock("CREST", ruta_macros + "bloque_crest.sci"); 
    // (Añade aquí las instrucciones de tu paleta si las tienes)

    disp("¡Toolbox CREST cargado exitosamente!");
    disp("Ya puedes abrir Xcos y usar tus bloques.");
    
catch
    disp("Error al cargar el Toolbox CREST. Asegúrate de ejecutar este archivo desde su ubicación.");
end
