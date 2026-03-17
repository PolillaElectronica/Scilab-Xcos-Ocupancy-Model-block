import pandas as pd
import numpy as np
import os
import sys
import time


def cargar_matrices(ruta_archivo, residentes, tipo_dia):
    df_tpm = pd.read_excel(ruta_archivo, sheet_name=f"tpm{residentes}_{tipo_dia}", skiprows=8)
    df_tpm.columns = ['Periodo', 'Estado_Actual', 'Prob_0', 'Prob_1', 'Prob_2', 'Prob_3', 'Prob_4', 'Prob_5', 'Prob_6'][:len(df_tpm.columns)]
    df_tpm = df_tpm.apply(pd.to_numeric, errors='coerce').fillna(0)
    return df_tpm

def simular_ocupacion(df_tpm, residentes):
    ocupacion = np.zeros(144, dtype=int)
    estado_actual = 0
    cols_prob = [f'Prob_{i}' for i in range(residentes + 1)]
    
    for t in range(1, 144):
        fila = df_tpm[(df_tpm['Periodo'] == t + 1) & (df_tpm['Estado_Actual'] == estado_actual)]
        if fila.empty:
            ocupacion[t] = estado_actual
            continue
            
        probabilidades = fila[cols_prob].values[0].astype(float)
        suma = np.sum(probabilidades)
        
        if suma == 0 or np.isnan(suma):
             probabilidades = np.zeros(len(probabilidades))
             probabilidades[estado_actual] = 1.0 
        else:
             probabilidades = probabilidades / suma 
        
        siguiente = np.random.choice(np.arange(residentes + 1), p=probabilidades)
        ocupacion[t] = siguiente
        estado_actual = siguiente
        
    return np.repeat(ocupacion, 10) # Expande a 1440 minutos

if __name__ == "__main__":
    np.random.seed(int(time.time()))
    carpeta = os.path.dirname(os.path.abspath(__file__))
    ruta_archivo = os.path.join(carpeta, 'Active_Occupancy_Simulation_Data_Sheet_10c.xlsm')
    
    # Recibir parámetros del bloque de Scilab
    residentes = int(sys.argv[1]) if len(sys.argv) > 1 else 3
    tipo_de_dia = sys.argv[2] if len(sys.argv) > 2 else 'wd'

    # Simular y guardar en CSV silenciosamente
    matriz_tpm = cargar_matrices(ruta_archivo, residentes, tipo_de_dia)
    resultado = simular_ocupacion(matriz_tpm, residentes)
    
    ruta_csv = os.path.join(carpeta, 'perfil_ocupacion.csv')
    np.savetxt(ruta_csv, np.column_stack((np.arange(1440), resultado)), delimiter=',', fmt='%d')
    print("OK")
