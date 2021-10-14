package live.moku;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import live.moku.model.CodeGenProperties;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
public class GenService {

    @Autowired
    private Configuration freeMarkerConf;

    @Autowired
    private CodeGenProperties properties;

    public void doDen() {
        File file = new File(properties.getDistPath());
        if (!file.exists()) {
            file.mkdir();
        } else {
            Arrays.stream(file.listFiles()).forEach(File::delete);
        }
        log.info("已删除" + properties.getDistPath() + "下所有文件");
        log.info("生成base.js.ftl...");
        this.genFile("base.js.ftl", properties.getBaseStyle());
    }

    private <T> void genFile(String fileName, T params) {
        String distFileName = fileName.split(".ftl")[0];
        try (
                BufferedWriter bw = Files.newBufferedWriter(Paths.get(properties.getDistPath(), distFileName),
                        StandardCharsets.UTF_8, StandardOpenOption.CREATE_NEW)
        ) {
            Map map = new HashMap();
            map.put("data", params);
            freeMarkerConf.getTemplate(fileName).process(map, bw);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }
    }

}
