package io.devpl.codegen.template.velocity;

import org.apache.velocity.exception.ParseErrorException;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.RuntimeServices;
import org.apache.velocity.runtime.resource.Resource;
import org.apache.velocity.runtime.resource.ResourceManagerImpl;
import org.apache.velocity.util.ExtProperties;

import java.util.ArrayList;
import java.util.List;

/**
 * @see org.apache.velocity.runtime.resource.ResourceManagerImpl
 */
public class VelocityResourceManager extends ResourceManagerImpl {

    @Override
    public void initialize(RuntimeServices rs) {
        /**
         * @see org.apache.velocity.runtime.resource.loader.FileResourceLoader#init(ExtProperties)
         */
        List<String> paths = new ArrayList<>();

        rs.setProperty(RuntimeConstants.RESOURCE_LOADER_PATHS, paths);

        super.initialize(rs);

        System.out.println(this);
    }

    @Override
    public Resource getResource(String resourceName, int resourceType, String encoding) throws ResourceNotFoundException, ParseErrorException {
        return super.getResource(resourceName, resourceType, encoding);
    }

    @Override
    protected Resource loadResource(String resourceName, int resourceType, String encoding) throws ResourceNotFoundException, ParseErrorException {
        return super.loadResource(resourceName, resourceType, encoding);
    }

    @Override
    public String getLoaderNameForResource(String resourceName) {
        return super.getLoaderNameForResource(resourceName);
    }
}
