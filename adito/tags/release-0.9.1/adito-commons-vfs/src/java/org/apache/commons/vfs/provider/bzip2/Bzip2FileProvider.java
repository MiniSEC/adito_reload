/*
 * Copyright 2002-2005 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.commons.vfs.provider.bzip2;

import org.apache.commons.vfs.Capability;
import org.apache.commons.vfs.FileName;
import org.apache.commons.vfs.FileObject;
import org.apache.commons.vfs.FileSystem;
import org.apache.commons.vfs.FileSystemException;
import org.apache.commons.vfs.FileSystemOptions;
import org.apache.commons.vfs.provider.compressed.CompressedFileFileProvider;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;

/**
 * Provides access to the content of bzip2 compressed files
 *
 * @author <a href="mailto:imario@apache.org">Mario Ivankovits</a>
 */
public class Bzip2FileProvider extends CompressedFileFileProvider
{
    protected final static Collection capabilities = Collections.unmodifiableCollection(Arrays.asList(new Capability[]
    {
        Capability.GET_LAST_MODIFIED,
        Capability.GET_TYPE,
        Capability.LIST_CHILDREN,
        Capability.READ_CONTENT,
        Capability.WRITE_CONTENT,
        Capability.URI,
        Capability.COMPRESS
    }));

    public Bzip2FileProvider()
    {
        super();
    }

    protected FileSystem createFileSystem(FileName name, FileObject file, FileSystemOptions fileSystemOptions) throws FileSystemException
    {
        return new Bzip2FileSystem(name, file, fileSystemOptions);
    }

    public Collection getCapabilities()
    {
        return capabilities;
    }
}
