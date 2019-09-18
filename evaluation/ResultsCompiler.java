import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.LinkedHashMap;

public class ResultsCompiler {

    public static void main(String[] args) throws Exception {
        File dir = new File(args[0]);
        File[] infoFiles = dir.listFiles((d, name) -> name.endsWith(".info"));
        if (infoFiles == null || infoFiles.length == 0) {
            System.out.println("No .info files found!");
            return;
        }

        BufferedWriter writer = new BufferedWriter(new FileWriter(args[1]));
        for (File info : infoFiles) {
            String entry = parseData(info);
            writer.write(entry);
        }
        writer.close();
    }

    private static String parseData(File info) throws Exception {
        LinkedHashMap<String, String> data = new LinkedHashMap<>();
        // Values in order we want them to appearf:
        data.put("SolverSolveTime", "");
        data.put("SavileRowTotalTime", "");
        data.put("SolverNodes", "");
        data.put("SolverSolutionsFound", "");

        BufferedReader reader = new BufferedReader(new FileReader(info));
        reader.lines().forEach(line -> {
            String[] entry = line.split(":");
            if (data.containsKey(entry[0])) {
                data.put(entry[0], entry[1]);
            }
        });
        reader.close();

        String name = info.getName();
        int filenameEnd = name.indexOf(".");
        String id = name.substring(0, filenameEnd);
        StringBuilder sb = new StringBuilder(id);
        data.forEach((key, value) -> {
            sb.append(",");
            sb.append(value);
        });
        sb.append("\n");
        return sb.toString();
    }
}
