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
package org.apache.commons.vfs.tasks;

import org.apache.commons.vfs.FileObject;

/**
 * A task that synchronises the destination folder to look exactly like
 * the source folder (or folders).
 *
 * @author <a href="mailto:adammurdoch@apache.org">Adam Murdoch</a>
 */
public class SyncTask
    extends CopyTask
{
    /**
     * Handles a destination for which there is no corresponding source file.
     */
    protected void handleMissingSourceFile(final FileObject destFile)
        throws Exception
    {
        log("deleting " + destFile);
        //destFile.delete( Selectors.SELECT_SELF );
    }

    /**
     * Check if this task cares about destination files with a missing source
     * file.
     */
    protected boolean detectMissingSourceFiles()
    {
        return true;
    }
}
