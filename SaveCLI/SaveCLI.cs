/*
 * SaveCLI - Command-Line Argument Interceptor
 * 
 * Description: 
 *   Captures command-line arguments and logs them to '%Temp%\SaveCLI\SaveCLI.txt'.
 *   Typically used to replace system binaries during integration testing or debugging.
 */
 
using System;
using System.IO;

class Program {
    static void Main(string[] args) {
        // Set path to save the log file to %Temp%\SaveCLI\SaveCLI.txt
        string tempDir = Path.Combine(Path.GetTempPath(), "SaveCLI");
        Directory.CreateDirectory(tempDir); // Safely creates the folder if it doesn't exist
        string logPath = Path.Combine(tempDir, "SaveCLI.txt");
        
        // Combine all passed arguments into a single string
        string arguments = string.Join(" ", args);
        File.WriteAllText(logPath, arguments);
    }
}
