
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class Foto_IdiomaConfiguration : EntityTypeConfiguration<Foto_Idioma> {
		public Foto_IdiomaConfiguration() {
			ToTable("Fotos_Idiomas");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Registro).WithMany(p => p.RegistrosIdiomas).HasForeignKey(p => new { p.IdRegistro });
			Property(p => p.Id).IsRequired();
			Property(p => p.IdRegistro).IsRequired();
			Property(p => p.Cultura).IsRequired().HasMaxLength(5);
			Property(p => p.Nombre).IsRequired().HasMaxLength(750);
			Property(p => p.Descripcion).IsRequired().HasMaxLength(2147483647);
		}
	}
}