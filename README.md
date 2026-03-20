# Xcos Occupancy Model Block
This repository contains a custom Xcos block designed for occupancy modeling. It includes the behavioral logic (macros) and initialization scripts required for the simulation.

## 📂 Structure

macros/: Contains the .sci files with the function logic.

scripts/: Contains .sce files for environment setup or data processing.

---
## 🚀 How to use it in Scilab

To use these blocks, Scilab needs to load the functions into its memory first. Follow these steps:
1. Clone or Download

Download this repository and extract it to your preferred working directory.
2. Load the Library (Macros)

Open Scilab and navigate to the macros folder inside the project. Run the following commands in the Scilab Console:

    // Navigate to the macros directory
  
    cd("path/to/Scilab-Xcos-Ocupancy-Model-block/Ocupancy_Model_Block/macros");

    // Build and load the library
  
    genlib("OccupancyLib", pwd());


3. Run the Scripts

If your block requires initial variables or environment setup, execute the script located in the scripts folder:

      exec("path/to/Ocupancy_Model_Block/scripts/Ocupancy_Model.sce");

4. Open Xcos

After running the steps above, you can open your Xcos diagram (.xcos). The custom blocks will now have their behavior linked to the functions you just loaded.

⚠️ Important Note on Paths

If you are using Windows, remember to use forward slashes / or double backslashes \\ in the console to avoid path errors. For example:
cd("C:/Users/Name/Documents/Scilab-Xcos-Ocupancy-Model-block/...")




## 📖 Scientific Background
This block implements occupancy models based on stochastic processes and patterns described in leading scientific literature. By leveraging **Python scripts** within the **Scilab/Xcos** environment, the block generates high-fidelity occupancy profiles that are essential for:
* Building Energy Performance Simulation (BEPS).
* Demand Side Management (DSM) in smart grids.
* Validation of HVAC control strategies.

The integration ensures that complex mathematical models derived from research papers are easily accessible as a standard drag-and-drop Xcos block.




