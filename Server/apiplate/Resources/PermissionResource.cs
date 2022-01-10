namespace apiplate.Resources
{
    public class PermissionResource : BaseResource
    {
        public bool Create { get; set; }

        public bool Read { get; set; }
        public bool Update { get; set; }
        public bool Delete { get; set; }
        public PermissionResource()
        {

        }
        public PermissionResource(bool create, bool read, bool update, bool delete)
        {
            Create = create;
            Read = read;
            Update = update;
            Delete = delete;
        }

    }
}