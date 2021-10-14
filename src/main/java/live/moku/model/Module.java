package live.moku.model;

import lombok.Data;

import java.util.List;

@Data
public class Module extends Meta {

    private List<ModuleSpec> spec;
}
