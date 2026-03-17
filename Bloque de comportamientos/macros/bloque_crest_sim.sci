function block = bloque_crest_sim(block, flag)
    if flag == 1 then
        residentes = block.rpar(1);
        tipo_dia_num = block.rpar(2);
        tiempo_actual = scicos_time();

        global PERFIL_CREST;
        
        // --- LA CLAVE: Solo llamamos a Python al inicio (tiempo 0) ---
        // Si el tiempo es 0, forzamos la ejecución de Python para tener un nuevo perfil aleatorio
        if tiempo_actual == 0 then
            disp("Generando nueva simulación estocástica en Python...");
            
            str_dia = "wd";
            if tipo_dia_num == 1 then str_dia = "we"; end

            // --- NUEVA LOCALIZACIÓN DE RUTAS UNIVERSAL ---
            global CREST_ROOT;
            if isempty(CREST_ROOT) then
                error("Error: La ruta base del toolbox CREST no está definida. Por favor, ejecuta loader.sce primero.");
            end
            
            ruta_scripts = CREST_ROOT + "scripts" + filesep();
            script_py = ruta_scripts + "ocupacion_xcos.py";
            archivo_csv = ruta_scripts + "perfil_ocupacion.csv";

            if isfile(archivo_csv) then mdelete(archivo_csv); end
            
            // --- COMPATIBILIDAD WINDOWS / LINUX PARA PYTHON ---
            comando_py = "python3";
            if getos() == "Windows" then
                comando_py = "python"; // En Windows suele ser 'python' a secas
            end
            
            // Ejecutar Python
            comando = msprintf("cd ""%s"" && %s ""%s"" %d %s", ruta_scripts, comando_py, script_py, residentes, str_dia);
            host(comando);
            // Ejecutar Python
            comando = msprintf("cd ""%s"" && python3 ""%s"" %d %s", ruta_scripts, script_py, residentes, str_dia);
            host(comando);

            // Cargar datos a la variable global
            if isfile(archivo_csv) then
                datos = csvRead(archivo_csv);
                PERFIL_CREST = datos(:, 2);
                disp("OK: Nuevo perfil aleatorio cargado para esta simulación.");
            else
                error("Fallo en Python. Revisa el archivo: " + script_py);
            end
        end

        // --- SALIDA ---
        // Usamos los datos que ya están cargados en PERFIL_CREST
        minuto_entero = floor(tiempo_actual) + 1;
        
        // Evitar errores si el tiempo supera 1440
        min_idx = modulo(minuto_entero - 1, 1440) + 1;
        
        block.outptr(1) = PERFIL_CREST(min_idx);
    end
endfunction
