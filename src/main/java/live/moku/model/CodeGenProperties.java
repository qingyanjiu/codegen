package live.moku.model;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@ConfigurationProperties(prefix = "codegen", ignoreInvalidFields = true)
@Component
@Data
public class CodeGenProperties {

    private String distPath;

    private BaseStyle baseStyle;

    private Module module;

    private Scene scene;

}
