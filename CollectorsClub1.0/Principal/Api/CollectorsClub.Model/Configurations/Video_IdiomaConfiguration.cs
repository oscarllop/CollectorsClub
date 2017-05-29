
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class Video_IdiomaConfiguration : EntityTypeConfiguration<Video_Idioma> {
		public Video_IdiomaConfiguration() {
			ToTable("Videos_Idiomas");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Registro).WithMany(p => p.RegistrosIdiomas).HasForeignKey(p => new { p.IdRegistro });
			Property(p => p.Id).IsRequired();
			Property(p => p.IdRegistro).IsRequired();
			Property(p => p.Cultura).IsRequired().HasMaxLength(5);
			Property(p => p.Nombre).IsRequired().HasMaxLength(250);
			Property(p => p.Descripcion).IsRequired().HasMaxLength(1000);
			Property(p => p.Url).IsRequired().HasMaxLength(250);
		}
	}
}