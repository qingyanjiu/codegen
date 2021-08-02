package live.moku.model;

import lombok.Data;

import java.util.List;

@Data
public class BaseStyle {

    private String name;

    private List<String> config;
}
