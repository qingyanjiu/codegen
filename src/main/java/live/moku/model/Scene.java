package live.moku.model;

import lombok.Data;

import java.util.List;

@Data
public class Scene extends Meta {

    private List<SceneSpec> spec;
}
