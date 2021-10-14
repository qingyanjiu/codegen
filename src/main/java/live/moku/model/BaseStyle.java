package live.moku.model;

import lombok.Data;

import java.util.List;

@Data
public class BaseStyle extends Meta {

    private List<BaseStyleSpec> spec;
}
