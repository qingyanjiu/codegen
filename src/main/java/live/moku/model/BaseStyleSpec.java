package live.moku.model;

import lombok.Data;

import java.util.List;

@Data
public class BaseStyleSpec {

    private String name;

    private List<String> config;
}
