package live.moku;

import live.moku.model.BaseStyle;
import live.moku.model.Module;
import live.moku.model.Scene;
import lombok.Data;
import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.List;

@ConfigurationProperties(prefix = "codegen", ignoreInvalidFields = true)
@Component
@Data
public class CodeGenProperties {

    private String distPath;

    private List<BaseStyle> baseStyles;

    private List<Module> modules;

    private List<Scene> scenes;

}
