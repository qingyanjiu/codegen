package live.moku.model;

import lombok.Data;

import java.util.List;

@Data
public class Module {

    private String name;

    private String routePath;

    private String sceneType;

    private List<String> config;

}
