using Avro;
using Avro.Specific;
// Define the User class based on the user.avsc schema

public class User : ISpecificRecord
    {
        public static Schema _SCHEMA = Schema.Parse(File.ReadAllText("user.avsc"));

        public virtual Schema Schema => _SCHEMA;

        public long Id { get; set; }
        public string Username { get; set; } = string.Empty;

        Schema ISpecificRecord.Schema => throw new NotImplementedException();

        object ISpecificRecord.Get(int fieldPos)
        {
            return fieldPos switch
            {
                0 => Id,
                1 => Username,
                _ => throw new AvroRuntimeException("Invalid field index"),
            };
        }

        void ISpecificRecord.Put(int fieldPos, object fieldValue)
        {
            switch (fieldPos)
            {
                case 0:
                    Id = (long)fieldValue;
                    break;
                case 1:
                    Username = (string)fieldValue;
                    break;
                default:
                    throw new AvroRuntimeException("Invalid field index");
            }
        }
    }
