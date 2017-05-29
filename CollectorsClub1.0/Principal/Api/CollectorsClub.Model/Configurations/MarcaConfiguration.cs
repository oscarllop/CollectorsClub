
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class MarcaConfiguration : EntityTypeConfiguration<Marca> {
		public MarcaConfiguration() {
			ToTable("Marcas");
			HasKey(p => new { p.Id });
			Property(p => p.Id).IsRequired().HasMaxLength(3);
			Property(p => p.Nombre).IsRequired().HasMaxLength(50);
		}
	}
}