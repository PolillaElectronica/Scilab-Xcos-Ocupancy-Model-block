function [x, y, typ] = bloque_crest(job, arg1, arg2)
    x = []; y = []; typ = [];
    select job
    case 'set' then
        x = arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        while %t do
            // Ventana de diálogo al hacer doble clic en el bloque
            [ok, residentes, tipo_dia_num, exprs] = scicos_getvalue(..
                "Parámetros del modelo CREST",..
                ["Número de residentes (1-6):"; "Tipo de día (0=Semana, 1=Finde):"],..
                list("vec", 1, "vec", 1), exprs);
                
            if ~ok then break; end

            // Validaciones de seguridad
            if residentes < 1 | residentes > 6 then
                message("Los residentes deben ser un número entre 1 y 6.");
                continue;
            end
            if tipo_dia_num <> 0 & tipo_dia_num <> 1 then
                message("El tipo de día debe ser 0 o 1.");
                continue;
            end

            // Guardar los datos en el bloque
            graphics.exprs = exprs;
            model = arg1.model;
            model.rpar = [residentes; tipo_dia_num];
            arg1.graphics = graphics;
            arg1.model = model;
            x = arg1;
            break;
        end
    case 'define' then
        // Valores por defecto al arrastrar el bloque
        residentes = 3;
        tipo_dia_num = 0; // 0 = wd (semana)

        model = scicos_model();
        model.sim = list("bloque_crest_sim", 5); // 5 = función de Scilab
        model.in = []; // Sin puertos de entrada (los datos van por doble clic)
        model.out = 1; // 1 puerto de salida (ocupación)
        model.evtin = 1; // 1 puerto de reloj (rojo)
        model.rpar = [residentes; tipo_dia_num];
        model.blocktype = 'c';
        model.dep_ut = [%f %t];

        exprs = [string(residentes); string(tipo_dia_num)];
        gr_i = ["xstringb(orig(1),orig(2),""CREST"",sz(1),sz(2),''fill'');"];

        x = standard_define([3 2], model, exprs, gr_i);
    end
endfunction
