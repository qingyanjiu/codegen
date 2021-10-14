package live.moku;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.*;
import freemarker.cache.StringTemplateLoader;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.HashMap;
import java.util.Map;

@Configuration
@SpringBootApplication
public class MokuApplication {

    public static void main(String[] args) {
        ApplicationContext ac = SpringApplication.run(MokuApplication.class, args);
//        GenService svc = ac.getBean(GenService.class);
//        svc.doDen();
        ParseSceneService parseSceneService = ac.getBean(ParseSceneService.class);
        parseSceneService.parseJson().forEach((key, value) -> System.out.println(key + "" + value.getClass()));
//        StringTemplateLoader stringTemplateLoader = new StringTemplateLoader();
//        stringTemplateLoader.putTemplate("fromdb", "<html><body>Hello fromdb ${name}</body></html>");
//        Configuration freemarker = ac.getBean(Configuration .class);
//        freemarker.setTemplateLoader(stringTemplateLoader);
//        try (
//                BufferedWriter bw = Files.newBufferedWriter(Paths.get("D:\\","index.html"),
//                        StandardCharsets.UTF_8, StandardOpenOption.CREATE)
//        ) {
//            Map map = new HashMap();
//            map.put("name", "world");
////            freemarker.getTemplate("index.ftl").process(map, bw);
//            freemarker.getTemplate("fromdb").process(map, bw);
//        } catch(IOException e) {
//            e.printStackTrace();
//        } catch (TemplateException e) {
//            e.printStackTrace();
//        }

    }

    @Bean
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
        return objectMapper;
    }

}
