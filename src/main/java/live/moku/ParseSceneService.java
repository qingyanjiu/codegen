package live.moku;

import com.fasterxml.jackson.databind.ObjectMapper;
import jdk.internal.util.xml.impl.Input;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

@Service
public class ParseSceneService {

    @Autowired
    private ObjectMapper objectMapper;

    public Map parseJson() {
        Map map = new HashMap();
        Resource resource = new ClassPathResource("jsonConfig/scene.json");
        StringBuilder sb = new StringBuilder();
        String tmp = "";
        try (
                BufferedReader br = new BufferedReader(new InputStreamReader(resource.getInputStream()));
        ) {
            while ((tmp = br.readLine()) != null) {
                sb.append(tmp);
            }
            map = objectMapper.readValue(sb.toString(), Map.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }
}
