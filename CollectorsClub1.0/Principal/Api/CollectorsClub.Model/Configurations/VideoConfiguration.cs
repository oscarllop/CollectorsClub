
using System.ComponentModel.DataAnnotations.Schema;
using CollectorsClub.Model.Entities;

using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
namespace CollectorsClub.Model.Configurations {
	public partial class VideoConfiguration : EntityTypeConfiguration<Video> {
		public VideoConfiguration() {
			ToTable("Videos");
			HasKey(p => new { p.Id });
			HasRequired(p => p.Marca).WithMany(p => p.Videos).HasForeignKey(p => new { p.IdMarca });
			Property(p => p.Id).IsRequired();
			Property(p => p.FechaAlta).IsRequired();
			
			Property(p => p.Nombre).IsRequired().HasMaxLength(250);
			Property(p => p.Descripcion).IsRequired().HasMaxLength(1000);
			Property(p => p.Url).IsRequired().HasMaxLength(250);
			Property(p => p.IdMarca).IsRequired().HasMaxLength(3);
		}
	}
}