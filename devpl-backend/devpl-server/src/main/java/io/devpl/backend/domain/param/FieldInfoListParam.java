package io.devpl.backend.domain.param;

import io.devpl.backend.common.PageParam;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FieldInfoListParam extends PageParam {

    private String fieldKey;
    private String fieldName;
}
