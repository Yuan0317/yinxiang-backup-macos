# Security and privacy

This tool downloads private notes and attachments to the local computer.

Never publish the backup database, ENEX exports, generated documents, terminal logs, cookies, passwords, or authentication tokens. Treat the entire backup directory as sensitive, even when individual filenames appear harmless.

If sensitive data is committed to Git, deleting the file in a later commit is not sufficient because it remains in history. Revoke exposed credentials and remove the data from the complete Git history before publishing.

For security issues in this wrapper, open a GitHub issue without including credentials or private note content. For issues in the underlying downloader, follow the reporting guidance in the upstream [evernote-backup](https://github.com/vzhd1701/evernote-backup) project.
