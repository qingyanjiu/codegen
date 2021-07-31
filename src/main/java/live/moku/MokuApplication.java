package live.moku;

import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.HashMap;
import java.util.Map;

@SpringBootApplication
public class MokuApplication {

    public static void main(String[] args) {
        ApplicationContext ac = SpringApplication.run(MokuApplication.class, args);
        StringTemplateLoader stringTemplateLoader = new StringTemplateLoader();
        stringTemplateLoader.putTemplate("fromdb", "<html><body>Hello fromdb ${name}</body></html>");
        Configuration freemarker = ac.getBean(Configuration .class);
        freemarker.setTemplateLoader(stringTemplateLoader);
        try (
                BufferedWriter bw = Files.newBufferedWriter(Paths.get("D:\\","index.html"),
                        StandardCharsets.UTF_8, StandardOpenOption.CREATE)
        ) {
            Map map = new HashMap();
            map.put("name", "world");
//            freemarker.getTemplate("index.ftl").process(map, bw);
            freemarker.getTemplate("fromdb").process(map, bw);
        } catch(IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }

    }

}
